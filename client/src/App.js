import React, { Component } from 'react';
import './App.css';

const headers = {
  "Content-Type": "application/json",
  "Accept":"application/json",
  "Access-Control-Allow-Origin": "*"
}

const results = fetch("http://localhost:4000/events",
  {
    headers,
    mode: 'no-cors'
  })
  .then(console.warn)

console.log("🤔results", results);

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
