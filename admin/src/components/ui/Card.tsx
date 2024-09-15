import classNames from "classnames";
import { HTMLAttributes } from "react";

export const Card = (props: HTMLAttributes<HTMLDivElement>) => {
  return (
    <div
      {...props}
      className={classNames(
        props.className,
        "max-w-sm p-6 border border-gray-200 rounded-lg"
      )}
    />
  );
};
