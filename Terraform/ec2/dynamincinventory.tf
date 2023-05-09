resource "null_resource" "localinventorynull01" {

	triggers = {
		mytest = timestamp()
	}

	provisioner "local-exec" {
	    command = "echo ${aws_instance.os1.tags.Name} ansible_host=${aws_instance.os1.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=/root/xyz.pem>> inventory"
            
           
	  }


	depends_on = [ 
			aws_instance.os1 
			]

}

resource "null_resource" "localinventorynull02" {
	triggers = {
		mytest = timestamp()
	}

	provisioner "local-exec" {
	    command = "echo ${aws_instance.os2.tags.Name} ansible_host=${aws_instance.os2.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=/root/terra_may.pem>> inventory"
                       
	  }

         depends_on = [ 
			null_resource.localinventorynull01 
			]
}

resource "null_resource" "mydynamicinventory" {

	triggers = {
		mytest = timestamp()
	}

	provisioner "local-exec" {
	    command = "scp inventory ansible_user@ansible_server:/tmp/"
      
            
	  }
	depends_on = [ 
			null_resource.localinventorynull02 , null_resource.localinventorynull01
			]
}

resource  "null_resource"  "ssh3" {

	triggers = {
		mytest = timestamp()
	}

	connection {
	    type     = "ssh"
	    user     = "ec2-user"
	    private_key = file("C:/abc/xyz.pem")
	    host     = var.ansible
	  }

	provisioner "remote-exec" {
	    inline = [
              "sudo chmod 777 /tmp/inventory",
              "sudo mv /tmp/inventory /root/ansible/inventory",
	    ]
	  }


# meta argument
	depends_on = [ 
			null_resource.myinventory
			]
}