# Kotlin Spring Boot Elm Starter

This project is a template to show how to be able to use Spring Boot in Kotlin for your server, and have a working setup for an Elm front-end.
This setup allows you to test locally, as well as compile and deploy on a server using [circle-ci](https://circleci.com).

This repo solves a few problems : 
* How to have live reloading while working in my front-end
* How to get my Elm talking to my Kotlin without having to restart / recompile
* How do I get my compiled Elm inside my application at deployment / packaging time

I have been using a [webpack](https://webpack.js.org/) based setup for Node projects like [elm-dungeon](https://github.com/jlengrand/elm-dungeon) but decided to follow another path for a spring-boot project.

If you use [Elm](https://guide.elm-lang.org) as a front-end language, you might be more likely to use Erlang, Haskell or Clojure for your Back-end :). But I am still in my journey towards functional programming, and being a Java guy I like the coziness of Kotlin!

## Structure

The code is currently split in 2 parts : 
* Back-end, in `src/main/kotlin` (written in Kotlin)
* Front-end, in `src/main/elm` (written in elm)
  * [elm quick start]( https://guide.elm-lang.org/ )

## Tools 

To run both parts, you will need (sounds obvious, but hey)

* [an installed jdk]( https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html )
    * Works if you can run `$java -version` in your console
    * The kotlin code runs on the JVM, that is why
* [an installed kotlin runtime]( https://kotlinlang.org/ )
    * Works if you use intellij and follow this tutorial : https://kotlinlang.org/docs/tutorials/getting-started.html
    * Will be used to write the code
* [elm installed]( https://elm-lang.org/ )
    * Works if you can run `$ elm` in your terminal
    * Used to write the front-end
* [NodeJs installed]( https://nodejs.org/en/ )
    * Works if you can run `$ npm -v` in your terminal
    * Used by create-elm-app
* [create-elm-app installed]( https://www.npmjs.com/package/create-elm-app#getting-started )
    * Works if you can run `$ elm-app` in your terminal
    * Allows to run the dev server for the front-end

## Running the application locally

### Running the API

To run the API, the simplest is to run `./gradlew bootRun` (or `./gradlew.bat bootRun` on Windows).

You should see something like this 

```
[jlengrand@juliens-MBP-fec9:~/IdeaProjects/kotlin-spring-boot-elm-starter]$ ./gradlew bootRun

> Task :bootRun

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.0.2.RELEASE)
......
<==========---> 83% EXECUTING [1m 50s]
> :bootRun
....
2019-03-20 21:16:39.319  INFO 9049 --- [           main] nl.lengrand.starter.AppKt                : Started AppKt in 5.52 seconds (JVM running for 6.19)
```

You should then be able to open your browser and type something like this

`http://localhost:8080/hello?name=bob`

You should get some JSON back, like this : 

```
{"name":"bob"}
```

### Running the front-end

To run the front-end, you need to go to `src/main/ui` and run `$elm-app start` from there.

```
$ cd src/main/ui
$ elm-app start
```

You should see something like that : 

```
[jlengrand@juliens-MacBook-Pro:~/IdeaProjects/kotlin-spring-boot-elm-starter/src/main/ui]$ ll
total 88
drwxr-xr-x  10 jlengrand  staff    320 Feb 22 16:17 .
drwxr-xr-x   5 jlengrand  staff    160 Mar  2 00:51 ..
-rw-r--r--   1 jlengrand  staff    187 Feb 22 16:17 .gitignore
Compiled successfully!

You can now view ui in the browser.

  Local:            http://localhost:3000/
  On Your Network:  http://192.168.178.24:3000/

Note that the development build is not optimized.
To create a production build, use elm-app build.
```

Now open your browser to `http://localhost:3000` to start playing (if your back-end runs as well)!

## Creating / Running a full package

In order to create a full fat jar, or run the complete application at once, you have to do three things: 

* Compile the front-end

    ```$cd src/main/ui/; elm-app build; cd -```
* Sync the compiled assets to the Kotlin resources
    ```$rsync -r  src/main/ui/build/ src/main/resources/static```
* Run / Compile the Spring Boot application
    ```$./gradlew bootRun``` or ```$./gradlew build```


## Continuous Integration / Deployment

This project uses .circle-ci to run tests on pushes, and mostly automate the boring part of having to merge the front-end in the back-end. It also auto deploys on the remote server.

See the `.circleci` folder and [circleci](https://circleci.com/login) if you want to know more, but in short

* Any push will trigger a ```$./gradlew test``` and ```$ elm-app build``` on the project
* Any merge to master will merge the front-end and deploy on a server.

## TODO

Right now .circle-ci is doing everything. Ideally I should create a gradle task that will compile and update so it can be done easily locally.

## Authors

* [Julien Lengrand-Lambert](https://github.com/jlengrand)

## LICENCE 

Do what you want with it :).