

resource "aws_instance" "server1" {
  count                  = 1 
  ami                    = "ami-0e731c8a588258d0d"
  instance_type          = "t2.micro"
  key_name               = "dev-key"
network_interface {
     network_interface_id = "${aws_network_interface.mv-ip1.id}"
     device_index = 0 
  }
tags = {
	Name = "Server-${count.index}"
	Env  = "Dev"
	Type = "Web"
 }
}


resource "aws_network_interface" "mv-ip1" {
  subnet_id   = aws_subnet.public_subnet_01.id
  private_ips = ["100.100.0.100"]
  security_groups = [aws_security_group.sg.id]
  tags = {
    Name = "primary_network_interface"
  }
}
