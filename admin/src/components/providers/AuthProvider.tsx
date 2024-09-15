import { PropsWithChildren } from "react";
import { useAuth } from "../../store/useAuth";
import { Redirect } from "wouter";

export const AuthProvider = (props: PropsWithChildren) => {
  const user = useAuth((state) => state.user);
  return (
    <>
      {props.children}
      {!user ? <Redirect to="/sign-in" /> : <></>}
    </>
  );
};
