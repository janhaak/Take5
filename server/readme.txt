Dev:
rackup
shotgun ( this reloads the app whenever changes are made, so you don't have to restart the server. win)

Production:
rackup -E production

Getting at the EC2 instance mongo's running on:
ssh -i "test/key.pem" ec2-user@ec2-174-129-188-30.compute-1.amazonaws.com

