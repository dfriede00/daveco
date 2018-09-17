provider "aws" {
  region     = "us-east-2"
}

resource "aws_instance" "webserver1" {
  ami = "ami-0552e3455b9bc8d50"
  instance_type = "t2.micro"
  
  tags {
    Name = "terraform-webserver1"
  }
}

