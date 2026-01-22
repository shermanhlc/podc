FROM debian:trixie-slim

ARG work_dir
ARG v_user

WORKDIR ${work_dir}
RUN mkdir -p ${work_dir}/podc

# install deps
COPY example_project/podc/deps.list ${work_dir}/podc
RUN apt-get update
RUN grep -vE '^#' ${work_dir}/podc/deps.list | xargs apt-get install -y

RUN useradd -ms /bin/bash ${v_user}
USER ${v_user}

RUN /usr/games/cowsay done!
