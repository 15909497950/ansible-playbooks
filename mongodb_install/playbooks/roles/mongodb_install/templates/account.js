rs.hello()
use admin
db.createUser(
  {
    user: "root",
    pwd: "{{ passwd }}",
    roles: [ { role: "root", db: "admin" }]
  }
)
db.createUser(
  {
    user: "app",
    pwd: "{{ app_passwd }}",
    roles: [ { role: "readWriteAnyDatabase", db: "admin" }]
  }
)
exit
