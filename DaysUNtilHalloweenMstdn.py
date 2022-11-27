import datetime as dt

today = dt.date.today()
thisHalloween = dt.datetime(year=dt.date.today().year, month=10, day=31)

today_number = int(today.strftime("%j"))
thisHalloween_number = int(thisHalloween.strftime("%j"))
nextHalloween_number = int(thisHalloween.strftime("%j")) + 366

if today_number == thisHalloween_number:
    message = "Happy Halloween!"
elif thisHalloween_number - today_number == 183:
    message = "Happy HALF-oween!"
elif today_number < thisHalloween_number:
    message = str(thisHalloween_number - today_number) + ' Days Until #Halloween'
elif today_number > thisHalloween_number:
    message = str(nextHalloween_number - today_number) + ' Days Until #Halloween'
else:
    message = "Everday is Halloween"

import requests

url = 'https://botsin.space/api/v1/statuses'
auth = {'Authorization': 'Bearer _____________________________________________ '}
params = {'status': message}

requests.post(url, data=params, headers=auth)
