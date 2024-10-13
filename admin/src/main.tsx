import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import "./index.css";
import { Routing } from "./routing";
import { ThemeProvider } from "./components/providers/ThemeProvider";

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <ThemeProvider defaultTheme="light" storageKey="ui-theme">
      <Routing />
    </ThemeProvider>
  </StrictMode>
);
