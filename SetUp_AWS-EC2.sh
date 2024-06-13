aws ec2 run-instances \
    --image-id ami-0f58b397bc5c1f2e8 \
    --count 1 \
    --instance-type t2.micro \
    --key-name ERIC-Robotics-PSIPL \
    --security-group-ids sg-03cc6452ec347a54a \
    --user-data file://SetUp-Docker.sh


