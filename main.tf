provider "aws" {
  region     = "us-east-2"
}

resource "aws_instance" "webserver1" {
  ami = "ami-3ec9fd5b"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sg_webservers.id}"]

  user_data = <<-EOF
      #!/bin/bash
      echo "Hello, World" > index.html
      nohup busybox httpd -f -p "${var.http_port}" &
      EOF

  tags {
    Name = "terraform-webserver1"
  }
}

resource "aws_security_group" "sg_webservers" {
  name = "allow_http"
  description = "Allow http traffic"

  ingress {
    from_port = "${var.http_port}"
    to_port = "${var.http_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # egress {
  #   from_port = 0
  #   to_port = 8080
  #   protocol = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]

    tags {
      Name = "tf_sg_allow_http"
    }
}
variable "http_port" {
  description = "http port of 8080"
  default = "8080"
}

output "public_ip" {
  value = "${aws_instance.webserver1.public_ip}"
}
output "Webserver1_ID" {
  value = "${aws_instance.webserver1.id}"
}
output "not sure" {
  value = "${aws_instance.webserver1.vpc_security_group_ids}"
}