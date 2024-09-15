import classNames from "classnames";
import { HTMLAttributes } from "react";

export const InputLabel = (props: HTMLAttributes<HTMLLabelElement>) => {
  return (
    <label
      {...props}
      className={classNames(props.className, "flex flex-col gap-1")}
    ></label>
  );
};
