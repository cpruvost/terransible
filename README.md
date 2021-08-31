# terransible

This image could be used in order to do Infra As Code with Oracle Cloud InfraStructure for exemple.

The Tools are :

- Usefull Tools Last version : jq, unzip, curl, wget
- Terraform
- OCI CLI (Command Line Interface of Oracle Cloud)
- OpenJdk 
- Vault

I put Vault client because it is nice to store all your Cloud secrets in Vault. You can get all of them in just one curl except your SSH files because with curl some \n was lost in the keys and so I used Vault client to get SSH files (base64 encoded).

I built this image in order to use it in Jenkins2 in declarative pipeline, so no need to have tools on Jenkins2 Agent Host !!!

agent {
​        docker { 
​            image 'cpruvost/terransible:latest'
​            args '-u root:root'
​        }

Sure you must know these tools because some of them does not run like that. For ex vault needs to get from the pipeline the Vault Address Server Ip and a Vault Token, and so on...  

## Feedback

If you like this repository, do not hesitate to add a star. If you have any
questions or ideas to enhance it, open an issue. Have fun!
