resource "aws_nat_gateway" "marques_nat_gateway" {
  count = length(aws_subnet.marques_public_subnet)

  allocation_id = aws_eip.marques_elastic_ip[count.index].id
  subnet_id     = aws_subnet.marques_public_subnet[count.index].id

  depends_on = [
    aws_internet_gateway.marques_internet_gateway
  ]

  tags = merge({Name = "${var.prefix_name}-nat-gateway"},
               {Public_NAT_Gateway = count.index},
                var.tags)
}