import { create } from "zustand";

export type AuthStore = {
  user?: {
    id: number;
  };
};

export const useAuth = create<AuthStore>((set) => ({
  user: undefined,

  authorize: () => {
    set({ user: { id: 1 } });
  },
}));
