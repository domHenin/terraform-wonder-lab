# Using Terraform to Create an Environment

`./modules/aws/compute-base/README.md`

## Documentation
create module ```compute-base/.``` and will need to reference *web erver URL*, *database server URL*, and *Time && Day* of created module. 

currently **public security group** is attached to database. *this was done for testing purposes*.


-----

## NeedTo:
- database: create sg that only allows ssh port  -- **done: b2826e1 gitpush**
- database: verify sql is installed and running
- database: verify ssh connection 
- apache ws: check user_data

-------

## `./outputs`
- web-server-url
- database-server-url
- time-date

---------------

## Thought Bucket
- database security-group is attached to private subnet that has no internet access

## License
[MIT](https://choosealicense.com/licenses/mit/)