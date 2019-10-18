This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.<br />
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.<br />
You will also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.<br />
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.<br />
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.<br />
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can’t go back!**

If you aren’t satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (Webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you’re on your own.

You don’t have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn’t feel obligated to use this feature. However we understand that this tool wouldn’t be useful if you couldn’t customize it when you are ready for it.

## Containerisation and Deployment

### Create the docker image.

To create the docker image, make sure you're in the project root directory and run the command below

`docker build -t [image_name]:[tag] .`

If you want to push the image to an image registry, you should tag it as follows;

| GGR                                        | Docker                                            |
| ------------------------------------------ | ------------------------------------------------- |
| `gcr.io/[project_name]/[image_name]:[tag]` | `docker.com/[repository_name]/[image_name]:[tag]` |

### Setup the GCP on your local computer and create the cluster

Install google cloud SDK on your machine and log into your project following the steps [here](https://cloud.google.com/sdk/docs/quickstarts) as per your use case

Once that's done, head over to the gcp console and create a cluster. This can also be done by running a command.

`gcloud container clusters create [CLUSTER_NAME] --zone [COMPUTE_ZONE]`

When the cluster is ready, run this command in the terminal where you installed the gcloud sdk.

`gcloud container clusters get-credentials [CLUSTER_NAME] --zone [[COMPUTE_ZONE] --project [PROJECT_NAME]`

After settingg the cluster context with the above command, making sure you are in the project root, run this command to deploy the application to kubernetes

`kubectl apply -f k8s/`

The command above will run the yaml configurations in the k8s/ folder against the cluster you created and create a deployment workload as well as a service. After a few moments you should be able to see the created resources by running these commands;

`kubectl get pods`

`kubectl get svc`

On the results of the svc command you should see an external IP column and an IP there, if it's still pending waiting a few more seconds and run the command again. When the IP appears, paste it into your browser, you should be able to see the application running. In my case it's running at

> http://35.187.111.12/
