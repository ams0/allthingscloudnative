# All Things Cloud Native Workshop

This workshop is designed to help you get started with Cloud Native development. It will walk you through the process of building a simple application, containerizing it, and deploying it to a Kubernetes cluster. You will also learn how to use some of the core Kubernetes concepts such as pods, deployments, services, and ingress.

## Contributing

This workshop is built using [MkDocs](https://www.mkdocs.org/). To contribute, you will need to install MkDocs and the Material theme:

```bash
pip3 install mkdocs
pip3 install mkdocs-material
```

You can then run the site locally:

```bash
mkdocs serve
```

## Structure

The file `mkdocs.yaml` contains the structure of all the workshops; it is a simple list of markdown files. The files are organized in directories, which are used to group the pages in the navigation bar. The order of the files in the list determines the order in the navigation bar. The file `docs/index.md` is the landing page of the site and the file `docs/about.md` is the about page. Each folder/subworkshop has its own `index.md` file which is the landing page for that subworkshop.

## License
Copyright Lovelace Engineering B.V. 2023