# CoolStore Online Store App

## Overview
CoolStore is an online store web application sample built using devfile applications(Spring Boot, Quarkus, Vert.x, 
Node.js and AngularJS) adopting the microservices architecture.

* **Web**: A Node.js/Angular front-end
* **API Gateway**: aggregates API calls to back-end services and provides a condenses REST API for front-end
* **Catalog**: a REST API for the product catalog and product information
* **Inventory**: a REST API for product's inventory status

```
                    +-------------+
                    |             |
                    |     Web     |
                    |             |
                    |   Node.js   |
                    |  AngularJS  |
                    +------+------+
                          |
                          v
                    +------+------+
                    |             |
                    | API Gateway |
                    |             |
                    |   Vert.x    |
                    |             |
                    +------+------+
                          |
                +---------+---------+
                v                   v
          +------+------+     +------+------+
          |             |     |             |
          |   Catalog   |     |  Inventory  |
          |             |     |             |
          | Spring Boot |     |   Quarkus   |
          |             |     |             |
          +-------------+     +-------------+
```

## Deploy the Workshop on Che
