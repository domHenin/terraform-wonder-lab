# Using Terraform to Create an Environment

`./modules/aws/compute-base/README.md`

## Documentation
create module ```compute-base/.``` and will need to reference *web erver URL*, *database server URL*, and *Time && Day* of created module. 

currently **public security group** is attached to database. *this was done for testing purposes*.


-----

## NeedTo:
- database: create sg that only allows ssh port
- databse: verify sql is installed and running

-------

## `./outputs`
- web-server-url
- database-server-url
- Time-Date

---------------

## License
[MIT](https://choosealicense.com/licenses/mit/)