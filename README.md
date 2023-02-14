# Angular Playground

## Install

```bash
git clone https://github.com/n3wborn/angular-playground.git
cd angular-playground
make install
```

## Getting started

`make install` will:
 
- build an image from the Dockerfile
- start a rootless container from this image
- trigger `npm install`
- run `npm run start`

Now you can see Angular is live if you browse to `http://localhost:4200`

## Notes

The Makefile provides:

- `make ng` provides `ng` commands **from the host**.
- `make bash` to get a shell from the container
- `make add_deps` to add dependencies
- `make add_dev_deps` to add --dev dependencies
- same to remove deps with `make rm_deps` or `make rm_dev_deps`
