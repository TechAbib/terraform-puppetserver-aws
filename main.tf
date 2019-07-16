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
            "sudo sed -i '28s/prohibit-password/yes/' /etc/ssh/sshd_config"
            "sudo sed -i '52s/no/yes/' /etc/ssh/sshd_config"
            "sudo service ssh restart"
            "sudo echo '127.0.0.1  puppetmaster.example.com  puppetmaster  puppet localhost localhost.localdomain' > /etc/hosts"
            "sudo wget https://s3.amazonaws.com/pe-builds/released/2018.1.3/puppet-enterprise-2018.1.3-ubuntu-16.04-amd64.tar.gz -O /root/puppetserver.tar.gz"
            "sudo usermod --password $(openssl passwd -1 {12345678}) root"
            "tar -xvzf /root/puppetserver.tar.gz" 
            "mv /root/puppet-enterprise* /root/puppetserver"
            "wget pe.conf -O /root/pe.conf"
            
            
    ]
  }
  
}
