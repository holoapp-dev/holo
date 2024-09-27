import { fetcher } from "./fetcher";

export const auth = async (data: {
  email: string;
  password: string;
  rememberMe: boolean;
}) => {
  return (
    await fetcher.post("auth/login", {
      json: data,
    })
  ).url;
};
