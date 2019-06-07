# To generate a Jupyter book

```
jupyter-book create boutiques-tutorial --out-folder ./neurolibre-book --content-folder ./notebooks --overwrite
jupyter-book build ./neurolibre-book/boutiques-tutorial
```

# To preview the book

```
cd neurolibre-book/boutiques-tutorial
sudo gem install bundler
sudo bundle install
sudo make serve
```
