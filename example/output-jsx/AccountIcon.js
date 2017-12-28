import React from 'react';
import { pure } from 'recompose';

import "./Icon.css";

const AccountIcon = ({ ...props }) => (
	<div className="Icon">
		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
			 <path d="M256 85.333c47.147 0 85.333 38.187 85.333 85.334S303.147 256 256 256s-85.333-38.187-85.333-85.333S208.853 85.333 256 85.333m0 213.334c94.293 0 170.667 38.186 170.667 85.333v42.667H85.333V384c0-47.147 76.374-85.333 170.667-85.333z"/>
		</svg>
	</div>
);

const PureAccountIcon = pure(AccountIcon);

export default PureAccountIcon;
