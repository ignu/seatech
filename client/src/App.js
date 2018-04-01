import React, { Component } from 'react';
import './App.css';

const results = fetch("http://localhost:8080/events")
  .then(r => r.json())
  .then(console.warn)

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
        </header>
      </div>
    );
  }
}

export default App;
