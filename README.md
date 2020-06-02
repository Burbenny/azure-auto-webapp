# azure-web-app-auto
automating the deployment of code to azure web apps, currently the infrastructure is built for wordpress cms

# Provisioning Azure resources
log in to the azure cloud shell and cd into cloud drive. git clone this repository. cd into this repository and perform terraform init. Afterwhich perform terraform plan and terraform apply after ensuring that the relevant resources are the ones you wish to provision. After doing so, the relevant resources will be deployed into azure portal and can be checked on the azure portal.

The resources created for this particular script is for initialising a bare wordpress CMS. There is a mysql database that is created as well for the use of instaling wordpress.

# Configuring Web app 
The next step is to type bash webappconfig.sh. In doing so, we will be required to enter a github link where the project will be cloned from. Type in the necessary password for authentication if needed and the web app will be ready for viewing. Go to azure portal and select the app service created. In overview select browse and you will be brought to the web page. 

Cloned repo can be accessed by ssh into the web app and be found in the /wwwroot folder.
