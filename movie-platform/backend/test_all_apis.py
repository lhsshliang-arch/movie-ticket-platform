import requests, json

BASE = 'http://127.0.0.1:8000/api'
errors = []

def test(method, path, label, expected_status=None, auth=None, data=None):
    url = BASE + path
    headers = {}
    if auth:
        headers['Authorization'] = f'Bearer {auth}'
    try:
        if method == 'GET':
            r = requests.get(url, headers=headers)
        elif method == 'POST':
            r = requests.post(url, json=data, headers=headers)
        elif method == 'PATCH':
            r = requests.patch(url, json=data, headers=headers)
        elif method == 'PUT':
            r = requests.put(url, json=data, headers=headers)
        elif method == 'DELETE':
            r = requests.delete(url, headers=headers)

        ok = expected_status is None or r.status_code == expected_status
        detail = ''
        if not ok:
            detail = f' [expected {expected_status}, got {r.status_code}]'
            errors.append(f'{label}: {r.status_code} - {r.text[:100]}')
        print(f'  {method:6} {path:40} -> {r.status_code} {label}{detail}')
        return r
    except Exception as e:
        errors.append(f'{label}: {e}')
        print(f'  {method:6} {path:40} -> FAIL {label}: {e}')
        return None

# First, ensure we have test data (admin session)
print('=== Setup test data ===')
r = test('POST', '/auth/login/', 'admin login', 200, data={'username':'admin','password':'admin123'})
admin_token = r.json().get('access') if r else None

# Check existing sessions
test_session_id = None
test_hall_id = None
test_cinema_id = None

if admin_token:
    r = requests.get(BASE + '/movies/admin/sessions/', headers={'Authorization': f'Bearer {admin_token}'})
    items = r.json().get('results', [])
    if items:
        test_session_id = items[0]['id']
        test_hall_id = items[0]['hall']
        print(f'  Using existing session id={test_session_id}')
    else:
        # Check halls
        r = requests.get(BASE + '/movies/admin/halls/', headers={'Authorization': f'Bearer {admin_token}'})
        halls = r.json().get('results', [])
        if halls:
            test_hall_id = halls[0]['id']
        else:
            # Check cinemas
            r = requests.get(BASE + '/movies/admin/cinemas/', headers={'Authorization': f'Bearer {admin_token}'})
            cinemas = r.json().get('results', [])
            if cinemas:
                test_cinema_id = cinemas[0]['id']
            else:
                r = requests.post(BASE + '/movies/admin/cinemas/', json={'name':'Test Cinema','address':'Addr','phone':'123'}, headers={'Authorization': f'Bearer {admin_token}'})
                if r.status_code == 201:
                    test_cinema_id = r.json()['id']
            # Create hall
            r = requests.post(BASE + '/movies/admin/halls/', json={'name':'Hall A','cinema':test_cinema_id,'capacity':100}, headers={'Authorization': f'Bearer {admin_token}'})
            if r.status_code == 201:
                test_hall_id = r.json()['id']
        # Create session
        r = requests.post(BASE + '/movies/admin/sessions/', json={'movie':1,'hall':test_hall_id,'start_time':'2026-05-21T20:00:00Z','price':'49.90','total_tickets':100,'sold_tickets':0}, headers={'Authorization': f'Bearer {admin_token}'})
        if r.status_code == 201:
            test_session_id = r.json()['id']
        print(f'  Created session id={test_session_id}, hall={test_hall_id}')
    print(f'  Setup done: session_id={test_session_id}')
else:
    errors.append('Cannot login as admin for setup')
    print('  FATAL: cannot setup test data')

print()
print('=== 1. Public APIs ===')
test('GET', '/movies/', 'movie list', 200)
test('GET', '/movies/1/', 'movie detail', 200)
test('GET', '/movies/1/sessions/', 'movie sessions', 200)
if test_session_id:
    test('GET', f'/movies/sessions/{test_session_id}/', 'session detail', 200)
test('GET', '/movies/categories/', 'categories', 200)
test('GET', '/movies/admin/halls/', 'hall list', 200)
test('GET', '/movies/admin/cinemas/', 'cinema list', 200)
test('GET', '/movies/admin/sessions/', 'session list', 200)

print()
print('=== 2. Auth APIs ===')
r = test('POST', '/auth/register/', 'register', 201, data={'username':'user1','password':'123456'})
user_token = r.json().get('access') if r and r.status_code == 201 else None
if not user_token:
    r = test('POST', '/auth/login/', 'login', 200, data={'username':'user1','password':'123456'})
    if r and r.status_code == 200:
        user_token = r.json().get('access')

r = test('POST', '/auth/login/', 'login', 200, data={'username':'user1','password':'123456'})
if r and r.status_code == 200:
    user_token = r.json().get('access')
    refresh = r.json().get('refresh')
    if refresh:
        test('POST', '/auth/refresh/', 'refresh token', 200, data={'refresh': refresh})

print()
print('=== 3. User APIs ===')
if user_token:
    test('GET', '/auth/profile/', 'get profile', 200, auth=user_token)
    test('PATCH', '/auth/profile/', 'update profile', 200, auth=user_token, data={'phone':'13800138000'})
    test('POST', '/auth/change-password/', 'change pw', 200, auth=user_token, data={'old_password':'123456','new_password':'newpass123'})
    test('POST', '/auth/change-password/', 'change pw back', 200, auth=user_token, data={'old_password':'newpass123','new_password':'123456'})
    test('GET', '/orders/', 'my orders', 200, auth=user_token)
else:
    errors.append('Cannot get user token')

print()
print('=== 4. Order Flow ===')
if user_token and test_session_id:
    r = test('POST', '/orders/', 'create order', 201, auth=user_token, data={'session':test_session_id,'quantity':2})
    if r and r.status_code == 201:
        oid = r.json()['id']
        r = test('GET', '/orders/', 'order list', 200, auth=user_token)
        test('GET', f'/orders/{oid}/', 'order detail', 200, auth=user_token)
        test('PATCH', f'/orders/{oid}/pay/', 'pay order', 200, auth=user_token)

    r2 = test('POST', '/orders/', 'create order 2', 201, auth=user_token, data={'session':test_session_id,'quantity':1})
    if r2 and r2.status_code == 201:
        oid2 = r2.json()['id']
        test('PATCH', f'/orders/{oid2}/cancel/', 'cancel order', 200, auth=user_token)
else:
    if not user_token:
        errors.append('Order flow: no user token')
    if not test_session_id:
        errors.append('Order flow: no test session')

print()
print('=== 5. Admin CRUD ===')
if admin_token:
    r = test('POST', '/movies/admin/cinemas/', 'create cinema', 201, auth=admin_token, data={'name':'CRUD Test','address':'Addr','phone':'123'})
    cid = r.json().get('id') if r else None
    if cid:
        test('PUT', f'/movies/admin/cinemas/update/{cid}/', 'update cinema', 200, auth=admin_token, data={'name':'Updated','address':'New','phone':'456'})

    r = test('POST', '/movies/admin/halls/', 'create hall', 201, auth=admin_token, data={'name':'TestHall','cinema':cid,'capacity':80})
    hid = r.json().get('id') if r else None
    if hid:
        test('PUT', f'/movies/admin/halls/update/{hid}/', 'update hall', 200, auth=admin_token, data={'name':'TestHall+','cinema':cid,'capacity':90})

    r = test('POST', '/movies/admin/sessions/', 'create session', 201, auth=admin_token, data={'movie':1,'hall':hid,'start_time':'2026-05-22T18:00:00Z','price':'39.90','total_tickets':60,'sold_tickets':0})
    tsid = r.json().get('id') if r else None

    # Stats
    test('GET', '/orders/all/', 'all orders', 200, auth=admin_token)
    test('GET', '/admin/stats/overview/', 'overview', 200, auth=admin_token)
    test('GET', '/admin/stats/category-orders/', 'category orders', 200, auth=admin_token)
    test('GET', '/admin/stats/daily-box-office/', 'daily box office', 200, auth=admin_token)
    test('GET', '/admin/stats/movie-ranking/', 'movie ranking', 200, auth=admin_token)

    # Cleanup test data from this run
    if tsid:
        test('DELETE', f'/movies/admin/sessions/delete/{tsid}/', 'delete session', 204, auth=admin_token)
    if hid:
        test('DELETE', f'/movies/admin/halls/delete/{hid}/', 'delete hall', 204, auth=admin_token)
    if cid:
        test('DELETE', f'/movies/admin/cinemas/delete/{cid}/', 'delete cinema', 204, auth=admin_token)

print()
if errors:
    print(f'=== {len(errors)} ERRORS ===')
    for e in errors:
        print(f'  {e}')
else:
    print('=== ALL 30+ TESTS PASSED ===')
