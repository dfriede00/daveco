provider "aws" {
  region     = "us-east-2"
}

resource "aws_instance" "webserver1" {
  ami = "ami-40d28157"
  instance_type = "t2.micro"
  
  user_data = <<-EOF
      #!/bin/bash
      echo "Hello, World" > index.html
      nohup busybox httpd -f -p 8080 &
      EOF

  tags {
    Name = "terraform-webserver1"
  }
}

resource "aws_security_group" "webservers" {
  name    ="webservers"
  description = "Allows all inbound traffic"
  
  ingress {
    
  }

}