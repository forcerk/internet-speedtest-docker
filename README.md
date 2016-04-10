# internet-speedtest-docker

__**Spoiler Alert**__

This project won't help you with your connection, actually this project born when I need to monitoring the speed of my Internet, create a report to send to my ISP take some action. So, using **Docker Compose** I put together three containers with the tools needed to monitoring and display the status of your Internet (and I know that tool can do more or can be better).

Here in Brazil is a mess to contract a good ISP, they just don't delivery the speed they should for the users. Generally in a small business or a residence you can't pay for a very expensive plans where they certify the bandwidth delivered. So you have to call them many times complaining about the speed of your internet connection and always they will ask you to do that Internet Tests Online, such as [SpeedTest](http://www.speedtest.net), [AT&T SpeedTest](http://www.att.com/speedtest/), [TestMyNet](http://testmy.net), most of this tests is based only on ICMP messages that don't reflect your real bandwidth on that time. Or even worse your ISP can allow all trafic ICMP so when you test appers that you have a good speed but when you have to download some content you can't do it that well. There are much more to talk about it but I don't wanna spend so much time talk about the things that are wrong here.


## Running container
The only requirement to run this compose is have Docker Compose installed, if you need to install you can [click here]() to check out how can you do that. After installed the only thing you need is export a variable and run the compose as command available below:

```shell
cd internet-speedtest-docker

export GRAFANA_PASSWD=your_password
docker-compose up -d 
```

## Docker Compose
As you probably know Docker Compose is a tool to let you running a multi-container application, so as I sad before I put together some contaiers to make everything work together. They are described below:

### InfluxDB (DB)
InfluxDB is a database tool based on time-series, so every event is registrate with their timestamp. I decided to use InfluxDB at first because has great integration with Grafana and second I don't take cara about timestamp and how generate the graphs based on time.

I used [tutumcloud/influxdb](https://github.com/tutumcloud/influxdb) image because is very useful and all parametrized so is easy to use.

### Grafana (Web)
Grafana is a tool to create and manage dashboards and graphs. It's a really cool tool and as I sad earlier has a perfect integration with InfluxDB.

When I started this project I used [tutumcloud/grafana](https://github.com/tutumcloud/grafana) image, however they stopped to update grafana image beacause the new version has a different way to be installed, so it's deprecated. So I used [grafana](https://hub.docker.com/r/grafana/grafana/) original image as a base system to generate my own image.


### SpeedTest (Testing)


