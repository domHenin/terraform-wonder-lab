# Using Terraform to Create an Environment

`./modules/aws/network-base/README.md`

## Documentation

create module ```network-base/.``` and will need to reference *public subnet id*, *private subnet id*, and *security group* for creating instance in ```compute-base/.``` module. in order to later call the needed IDs an **outputs.tf** file will be created.   

---

## `./outputs`

- sub_pub_id
- sub_priv_id
- sg_pub

---------------

## License

[MIT](https://choosealicense.com/licenses/mit/)



