import classNames from "classnames";
import { ButtonHTMLAttributes } from "react";

export const Button = (props: ButtonHTMLAttributes<HTMLButtonElement>) => {
  return (
    <button
      {...props}
      className={classNames(
        props.className,
        "bg-seagull-400 hover:bg-seagull-500 focus:bg-seagull-500 transition text-white py-2 px-4 rounded-lg"
      )}
    ></button>
  );
};
