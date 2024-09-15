/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        seagull: {
          50: "#f0faff",
          100: "#e1f3fd",
          200: "#bbe9fc",
          300: "#80d8f9",
          400: "#38c4f4",
          500: "#12aee5",
          600: "#068dc3",
          700: "#06709e",
          800: "#095e83",
          900: "#0e4e6c",
          950: "#093248",
        },
      },
    },
  },
  plugins: [],
};
