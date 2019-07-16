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
         "sudo service ssh restart
     echo "setting up hostname in hosts file"
     sudo echo "127.0.0.1  puppetmaster.example.com  puppetmaster  puppet localhost localhost.localdomain" > /etc/hosts
     echo "starting the download of puppet master"
     sudo wget https://s3.amazonaws.com/pe-builds/released/2018.1.3/puppet-enterprise-2018.1.3-ubuntu-16.04-amd64.tar.gz -O /root/puppetserver.tar.gz
     echo "download complete. kept it in /root/puppetserver.tar.gz"
     echo "taking a backup in windows folder"
     sudo cp /root/puppetserver.tar.gz /vagrant/puppetserver.tar.gz
     echo "backup complete"
     echo "setting root password"
     sudo /usr/bin/passwd root <<EOF
12345678
12345678
EOF
"
    ]
  }
  
}
