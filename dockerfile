FROM debian:trixie-slim

ARG work_dir
ARG v_user

WORKDIR ${work_dir}
RUN mkdir -p ${work_dir}/podc

RUN useradd -ms /bin/bash ${v_user}

# install deps
# todo: the COPY dir should be abstract
COPY example_project/podc/deps.list ${work_dir}/podc
RUN apt-get update
RUN grep -vE '^#' ${work_dir}/podc/deps.list | xargs apt-get install -y

# is it possible to make this conditional on if init exists?
COPY example_project/podc/commands/init ${work_dir}/podc
RUN su ${v_user} -c ${work_dir}/podc/init

USER ${v_user}

# this should probably be part of something else? a "checkup"
RUN rustc --version
RUN /usr/games/cowsay done!
