# fhiraas-microservice-kubernetes

A Quick way to invite the InterSystems FHIR Accelerator Service to your Microservice party in a Kubernetes Cluster for immediate use.  The solution uses [Nginx](https://www.nginx.com) proxy ninja maneuvers to get the job done.

## Prerequisites

You'll need a couple of things if you want to deploy this in the manner it was presented in the community post. Its mainly positioned as a starting point or an approach for those wishing to plug FHIR capability in quickly for development, I cut a lot of corners with secrets etc but wanted feedback on the approach in return for the effort not a masterclass on secret management.

> 🔥 Environment
> 
> For this demonstration we are parked directly onto a Kubernetes Master Node tainted to put in work.

## FHIR up the FHIR Accelerator Service

- [ ] [Create a account in the InterSystems Cloud ](https://gitlab.com/-/experiment/new_project_readme_content:08628bec7a790d72f5f9d5aabd50d2f3?https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) 
- [ ] [Create a FHIR Accelerator Service Deployment](https://gitlab.com/-/experiment/new_project_readme_content:08628bec7a790d72f5f9d5aabd50d2f3?https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) 
- [ ] [Create an Api Key](https://gitlab.com/-/experiment/new_project_readme_content:08628bec7a790d72f5f9d5aabd50d2f3?https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line)

> 🖇 Record the Endpoint and API Key
> 
> This is all we need from the FHIR Accelerator, we will interact with the service in our own way inside the Kubernetes Cluster.

## Clone this Repo
For the "Rest of the README", park yourself on a Tainted Kubernetes Master Node.  

```
git clone https://gitlab.com/isc_cloud/fhiraas-microservice-kubernetes.git
cd fhir-microservice-kubernetes
```

## Deploy to Kubernetes Cluster

- [ ] [Create a Namespace](https://gitlab.com/-/experiment/new_project_readme_content:08628bec7a790d72f5f9d5aabd50d2f3?https://gitlab.com/isc_cloud/fhiraas-microservice-kubernetes/-/settings/integrations)
- [ ] [Create a ConfigMap](https://gitlab.com/-/experiment/new_project_readme_content:08628bec7a790d72f5f9d5aabd50d2f3?https://gitlab.com/isc_cloud/fhiraas-microservice-kubernetes/-/settings/integrations)
- [ ] [Create a Deployment](https://gitlab.com/-/experiment/new_project_readme_content:08628bec7a790d72f5f9d5aabd50d2f3?https://gitlab.com/isc_cloud/fhiraas-microservice-kubernetes/-/settings/integrations)

```
git clone https://gitlab.com/isc_cloud/fhiraas-microservice-kubernetes.git
cd fhir-microservice-kubernetes
```

## Expose it!
- [ ] [Create a Service](https://gitlab.com/-/experiment/new_project_readme_content:08628bec7a790d72f5f9d5aabd50d2f3?https://gitlab.com/isc_cloud/fhiraas-microservice-kubernetes/-/settings/integrations)

## Throw some FHIR at it!
Included in this repo is a hostile, rustic, shell script for throwing some random patients into the Patient resource with a few bells and no whistles.  I needs some environment variables or you can just edit the variables directly in the script.  When running this script, ensure proper cpu fan operation and move objects from laptop area to prevent shuffling of objects while running.

```
bash bin/fhirbench.sh
```
## Scale It!

We're on a single node and exposing the service to a node port so not sure this will increase our throughput, but go nuts and scale away anyway.  

```
kubectl scale deployments/isc-fhiraas-deployment --replicas=30 -n isc-fhiraas
```
# Throw some more FHIR at it!

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!).  Thank you to [makeareadme.com](https://gitlab.com/-/experiment/new_project_readme_content:08628bec7a790d72f5f9d5aabd50d2f3?https://www.makeareadme.com/) for this template.

```
bash bin/fhirbench.sh
```



