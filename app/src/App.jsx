import { useState, useEffect } from "react";
import reactLogo from "./assets/react.svg";
import "./App.css";
import * as IPFS from "ipfs-core";

function App() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    spawnNode();
  }, []);

  async function spawnNode() {
    try {
      const node = await IPFS.create();
      console.log(node);
    } catch (error) {
      console.log(error);
    }
  }

  return (
    <div className="App">
      <div>
        <a href="https://vitejs.dev" target="_blank">
          <img src="/vite.svg" className="logo" alt="Vite logo" />
        </a>
        <a href="https://reactjs.org" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React</h1>
      <div className="button">
        {/* <button onClick={() => }>HUGEASS BUTTON</button> */}
        <p>
          Edit <code>src/App.jsx</code> and save to test HMR
        </p>
      </div>
      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p>
    </div>
  );
}

export default App;
