# Jekyll React Component

Simple gem adding `react_component` tag to jekyll. It brings in React using import maps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jekyll-react-component'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jekyll-react-component

## Usage

Example Clock Component

```
{% react_component {"name": "Clock", "props": {"dataTest": "test"}} %}
  class Clock extends React.Component {
    constructor(props) {
      super(props);
      this.state = {date: new Date()};
    }

    componentDidMount() {
    this.timerID = setInterval(
      () => this.tick(),
      1000
    );
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  tick() {
    this.setState({
      date: new Date()
    });
  }

    render() {
      return html`
        <div data-test="${this.props.dataTest}">
          <h1>Witaj, świecie!</h1>
          <h2>Aktualny czas: ${this.state.date.toLocaleTimeString()}.</h2>
        </div>`;
    }
}
{% endreact_component %}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jekyll-react-component. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/jekyll-react-component/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Jekyll::React::Components project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/jekyll-react-component/blob/master/CODE_OF_CONDUCT.md).
