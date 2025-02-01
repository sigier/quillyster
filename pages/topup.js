import { withPageAuthRequired } from "@auth0/nextjs-auth0";

export default function Topup(props) {
  return <div>This Topup</div>;
}

export const getServerSideProps = withPageAuthRequired(() => {
  return {
    props: {},
  };
});
