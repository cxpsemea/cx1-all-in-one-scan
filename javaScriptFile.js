import React, {Component} from 'react';


export default class Visualization extends Component {
    constructor(props) {
        super(props);
        this.state = {
            x: null,
        };
    }

    componentDidUpdate(prevProps, prevState, snapshot) {
        if(!this.props.x) {
            this.setState({
                x: null,
            });
        } else if(this.props.x !== prevProps.x) {
            this.setState({
                x: this.props.x,
            });
        }
    }

    render() {
        return (<div>X: {this.state.x}</div>)
    }
}