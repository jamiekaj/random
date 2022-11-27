from datetime import date
today = date.today()
Halloween = date(today.year, 10, 31)
until_Halloween = Halloween - today
print(until_Halloween.days, Days Until Halloween!)
