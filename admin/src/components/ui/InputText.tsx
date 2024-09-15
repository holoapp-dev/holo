import classNames from "classnames";
import { InputHTMLAttributes } from "react";

export const InputText = (props: InputHTMLAttributes<HTMLInputElement>) => {
  return (
    <input
      {...props}
      className={classNames(
        props.className,
        "bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg w-full p-2.5"
      )}
    />
  );
};
