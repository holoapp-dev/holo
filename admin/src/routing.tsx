import { Route } from "wouter";
import { SignIn } from "./pages/sign-in";
import { Main } from "./pages";

export const routes = [
  {
    path: "/sign-in",
    component: SignIn,
  },
  {
    path: "/",
    component: Main,
  },
];

export const Routing = () => {
  return (
    <>
      {routes.map((route) => (
        <Route component={route.component} path={route.path} key={route.path} />
      ))}
    </>
  );
};
