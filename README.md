# Example running [Apache Zeppelin](https://zeppelin.apache.org/) notebooks inside ShinyProxy 

The official Docker image [apache/zeppelin](https://hub.docker.com/r/apache/zeppelin) can be used.

For deployment on ShinyProxy the port must be set to 8080, e.g.:

```yaml
specs:
  - id: zeppelin
    display-name: Apache Zeppelin
    container-image: apache/zeppelin:0.8.1
    port: 8080
```

In order to store the notebooks, the volumes on the host need to be mounted to point to `/zeppelin/notebook` inside container (and to `/zeppelin/logs` for the logs):
```yaml
    container-volumes: [ "/tmp/zeppelin/#{proxy.userId}/notebook:/zeppelin/notebook", "/tmp/zeppelin/#{proxy.userId}/logs:/zeppelin/logs" ]
```
This will ensure that each user's notebooks are stored in a separate directory on the server.
By modifying the host paths other scenarios can be implemented, such as shared notebook storage per user group, or shared storage for all users.

In addition to the notebooks, also the "interpreter binding" configuration need to be stored.
This can be achieved by creating a folder on the Docker host containing [`conf` files from Apache Zeppelin](https://github.com/apache/zeppelin/tree/master/conf):
```bash
# creating `conf` folder
VERSION=0.8.1
cd /tmp/zeppelin
wget -O zeppelin.tar.gz https://github.com/apache/zeppelin/archive/v${VERSION}.tar.gz
tar --strip-components=1 -xvf zeppelin.tar.gz zeppelin-${VERSION}/conf
rm zeppelin.tar.gz
```
_(alternatively run the helper script `./createConf /tmp/zeppelin 0.8.1`)_

and then mounting it to the container:
```yaml
    container-volumes: [ "/tmp/zeppelin/#{proxy.userId}/notebook:/zeppelin/notebook", "/tmp/zeppelin/#{proxy.userId}/logs:/zeppelin/logs", "/tmp/zeppelin/conf:/zeppelin/conf" ]
```
Note that here the `conf` folder is shared across users.
