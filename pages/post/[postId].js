import { withPageAuthRequired } from "@auth0/nextjs-auth0";

export default function Post(props) {
  return <div>This existing post</div>;
}

export const getServerSideProps = withPageAuthRequired(() => {
  return {
    props: {},
  };
});
