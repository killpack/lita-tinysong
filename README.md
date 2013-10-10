# lita-tinysong

`lita-tinysong` is a [Lita](https://github.com/jimmycuadra/lita) handler that lets 
Lita respond with [Tinysong](http://tinysong.com) links.

## Installation
```ruby
gem 'lita-tinysong', github: 'killpack/lita-tinysong'
```

## Configuration

You'll need a Tinysong API key: get one [here](http://tinysong.com/api).

```ruby
Lita.configure do |config|
  ...
  config.handlers.tinysong.api_key = 'your_api_key_goes_here'
  ...
end
```

## Usage

`killpack`: `Lita: groove me let the music play`

`Lita`: `http://tinysong.com/XtWt`
