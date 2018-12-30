# Test folder

This folder contains dockerfiles to build images and run the container to launch unit tests.

## Ubuntu

To build the ubuntu image, go to the ubuntu folder and launch the following:

``` bash
docker image build -t ubuntu-test-zsh-sdkman .
```

Then, you can launch the container in interactive mode:

``` bash
docker container run -it --rm ubuntu-test-zsh-sdkman
```

And then, to launch the tests from inside the container:

``` bash
./launch_tests.sh
```

**WARNING:** Tests can take a while, expect to wait for at least one minute.
