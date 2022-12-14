import React, { Fragment } from "react";

import EarSmall from "./small";
import EarBig from "./big";

export default function ear(props) {
  const { color, size } = props;
  return (
    <Fragment>
      {size === "small" &&
        <EarSmall color={color} />
      }
      {size === "big" &&
        <EarBig color={color} />
      }
    </Fragment>

  );
}
