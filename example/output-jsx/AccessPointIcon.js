import React from 'react';
import { pure } from 'recompose';

import "./Icon.css";

const AccessPointIcon = ({ ...props }) => (
	<div className="Icon">
		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
			 <path d="M105.173 105.173C66.56 143.787 42.667 197.12 42.667 256c0 58.88 23.893 112.213 62.506 150.827l30.08-30.08C104.32 346.027 85.333 303.36 85.333 256c0-47.147 18.987-90.027 49.92-120.747l-30.08-30.08m301.654 0l-30.08 30.08c30.933 30.72 49.92 73.6 49.92 120.747 0 47.36-18.987 90.027-49.92 120.747l30.08 30.08C445.44 368.213 469.333 314.88 469.333 256c0-58.88-23.893-112.213-62.506-150.827m-241.28 60.374C142.293 188.8 128 220.8 128 256s14.293 67.2 37.547 90.453l30.08-30.08c-15.36-15.36-24.96-36.693-24.96-60.373s9.6-45.013 24.96-60.373l-30.08-30.08m180.906 0l-30.08 30.08c15.36 15.36 24.96 36.693 24.96 60.373s-9.6 45.013-24.96 60.373l30.08 30.08C369.707 323.2 384 291.2 384 256s-14.293-67.2-37.547-90.453M256 213.333c-23.467 0-42.667 19.2-42.667 42.667s19.2 42.667 42.667 42.667 42.667-19.2 42.667-42.667-19.2-42.667-42.667-42.667z"/>
		</svg>
	</div>
);

const PureAccessPointIcon = pure(AccessPointIcon);

export default PureAccessPointIcon;
