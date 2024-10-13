import ky from "ky";

export const fetcher = ky.extend({
  prefixUrl: import.meta.env.VITE_API + "/",
});
