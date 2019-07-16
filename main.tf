provider "aws {
access_key = ""
secret_key = ""
region = "ap-southeast-1"
}

resource "aws_instance" "cicdvm" {
ami = "ami-04613ff1fdcd2eab1"
instance_type = "t2.medium"
root_block_device{
volume_size = "120"
}
provisioner "remote-exec" {
    inline = [
        ""
    ]
  }
  
}
